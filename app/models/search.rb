module Search
  extend self

  def collections(term)
    Collection._search(term)
  end

  def universal_search(term)
    PgSearch.multisearch(term)
  end
end
