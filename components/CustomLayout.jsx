/* eslint-env browser */

import {forwardRef, useState} from 'react'

const CustomLayout = forwardRef(({cmsGuideUrl = '/static/cms-guide.pdf', ...props}, ref) => {
  const [showPopup, setShowPopup] = useState(false)
  const [copied, setCopied] = useState(false)

  const handleBrandClick = (e) => {
    e.preventDefault()
    e.stopPropagation()
    setShowPopup(!showPopup)
  }

  const handleEmailCopy = async (e) => {
    e.preventDefault()
    e.stopPropagation()

    try {
      await navigator.clipboard.writeText('jordan@latzwebdesign.com')
      setCopied(true)
      setTimeout(() => {
        setCopied(false)
        setShowPopup(false)
      }, 2000)
    } catch (err) {
      console.log('Email: jordan@latzwebdesign.com')
      setCopied(true)
      setTimeout(() => {
        setCopied(false)
        setShowPopup(false)
      }, 2000)
    }
  }

  return (
    <div ref={ref} style={{height: '100vh', display: 'flex', flexDirection: 'column'}}>
      <div style={{flex: 1, minHeight: 0, overflow: 'auto'}}>{props.renderDefault(props)}</div>

      <footer
        style={{
          flexShrink: 0,
          padding: '10px 20px',
          background: '#111827',
          borderTop: '1px solid #18a1ad',
          textAlign: 'center',
          fontSize: '12px',
          position: 'relative',
          zIndex: 1000,
          fontFamily:
            '"Roboto", -apple-system, BlinkMacSystemFont, "Segoe UI", "Helvetica Neue", Arial, sans-serif',
        }}
      >
        <span style={{color: '#f9fafb'}}>
          Powered by{' '}
          <strong
            style={{
              color: '#18a1ad',
              cursor: 'pointer',
              textDecoration: 'underline',
              userSelect: 'none',
            }}
            onClick={handleBrandClick}
          >
            Latz Web Design
          </strong>{' '}
          <span
            style={{
              color: '#f2fcfe',
              cursor: 'pointer',
              fontSize: '14px',
              userSelect: 'none',
            }}
            onClick={handleBrandClick}
          >
            &#9432;
          </span>
        </span>

        {showPopup && (
          <div
            style={{
              position: 'fixed',
              bottom: '60px',
              left: '50%',
              transform: 'translateX(-50%)',
              background: '#f9fafb',
              border: '2px solid #18a1ad',
              borderRadius: '8px',
              padding: '20px',
              boxShadow: '0 8px 24px rgba(0,0,0,0.4)',
              zIndex: 10000,
              minWidth: '280px',
              fontFamily:
                '"Roboto", -apple-system, BlinkMacSystemFont, "Segoe UI", "Helvetica Neue", Arial, sans-serif',
            }}
          >
            <div
              style={{
                color: '#111827',
                marginBottom: '14px',
                fontWeight: 'bold',
                fontSize: '14px',
              }}
            >
              Need Help?
            </div>

            <button
              style={{
                color: copied ? '#f9fafb' : '#111827',
                cursor: 'pointer',
                padding: '10px 12px',
                background: copied ? '#18a1ad' : '#f2fcfe',
                borderRadius: '4px',
                border: '1px solid #18a1ad',
                width: '100%',
                fontSize: '12px',
                fontWeight: copied ? 'bold' : 'normal',
                fontFamily: 'inherit',
              }}
              onClick={handleEmailCopy}
            >
              {copied ? '✓ Copied to Clipboard!' : '📧  jordan@latzwebdesign.com'}
            </button>

            <a
              href={cmsGuideUrl}
              target="_blank"
              rel="noopener noreferrer"
              style={{
                display: 'block',
                color: '#f9fafb',
                padding: '10px 12px',
                background: '#111827',
                borderRadius: '4px',
                border: '1px solid #18a1ad',
                width: '100%',
                fontSize: '12px',
                fontFamily: 'inherit',
                textAlign: 'center',
                textDecoration: 'none',
                marginTop: '8px',
                boxSizing: 'border-box',
              }}
              onClick={(e) => e.stopPropagation()}
            >
              📖 How to Edit Your Website
            </a>

            <a
              href="https://latzwebdesign.com"
              target="_blank"
              rel="noopener noreferrer"
              style={{
                display: 'block',
                color: '#6b7280',
                fontSize: '11px',
                textAlign: 'center',
                marginTop: '12px',
                textDecoration: 'none',
                fontFamily: 'inherit',
              }}
              onClick={(e) => e.stopPropagation()}
            >
              latzwebdesign.com
            </a>
          </div>
        )}

        {showPopup && (
          <div
            style={{
              position: 'fixed',
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              zIndex: 9999,
            }}
            onClick={() => setShowPopup(false)}
          />
        )}
      </footer>
    </div>
  )
})

CustomLayout.displayName = 'CustomLayout'

export default CustomLayout
