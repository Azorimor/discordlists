import type { NextPage } from 'next'
import Searchbar from '../components/searchbar'

const Home: NextPage = () => {
  return (
    <div className="flex justify-center items-center dark:bg-gray-700">
      <div className="text-center">
        <h1 className="text-xl font-bold dark:text-white mt-5">Discord Bots and Servers</h1>
        <p className="text-md font-light dark:text-white pb-4">Find your new favorite discord bot & server</p>
        <Searchbar />
        <p className="text-xl dark:text-white">description</p>
      </div>
    </div>
  )
}

export default Home
