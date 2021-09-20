import type { NextPage } from 'next'
import Searchbar from '../components/searchbar'

const Home: NextPage = () => {
  return (
    <div className="flex justify-center items-center dark:bg-gray-700">
      <div className="text-center">
        <Searchbar />
        <p className="text-xl dark:text-white">description</p>
      </div>
    </div>
  )
}

export default Home
