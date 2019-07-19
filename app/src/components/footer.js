import React from 'react'

export default () => (
    <footer
      className='w-100 flex flex-row-ns pt2 pb2 h3 mt2 pl4 pr4 items-center justify-between bg-black black shadow-3 white absolute bottom-0 left-0'>
    <div id='logo' className= 'flex flex-wrap items-center justify-center'>
    <a className='contain bg-cncf bg-center white h-100 w4 mr4' href='https://cncf.io' title='leads to external cncf homepage'>
    <span className='o-0'>cncf</span>
    </a>
    <a className='contain bg-packet bg-center h-100 w4 mr4' href='https://packet.net' title='leads to external packet homepage'>
    <span className='o-0'>packet</span>
    </a>
    </div>
    <div id='source-code' className='flex items-center'>
        <a href='https://github.com/cncf/apisnoop' className='link f7 pl1 white flex flex-row items-center justify-center'>
        <img src='assets/github-logo-white.png' alt='the word github in white sans serif font' className='h1'/>
        <p>Source Code</p>
        </a>
      </div>
    </footer>
)