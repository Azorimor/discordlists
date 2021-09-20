import type { NextPage } from 'next'

const Home: NextPage = () => {
  return (
    <div className="flex justify-center items-center">
      <div className="text-center">
        <div className="bg-white shadow p-4 flex">
          <span className="w-auto flex justify-end items-center text-gray-500 p-2">
          <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          </span>
          <input type="text" className="w-full rounded p-2" placeholder="Bot details" />
          <button className="bg-red-400 hover:bg-red-300 rounded text-white p-2 pl-4 pr-4">
            <p className="font-semibold text-xs">Search</p>
          </button>
        </div>
        <p className="text-xl">description</p>
      </div>
    </div>
  )
}

export default Home
