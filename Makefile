OPML	?= PillarBlogs.opml
ABOUT	?= about.md

default: bag-compare-opml-and-about

bag-compare-opml-and-about: opml-not-in-about about-not-in-opml

opml-not-in-about:
	@for i in $$(cat ${OPML} | grep 'type="rss".*htmlUrl' | sed -e 's|^.*htmlUrl="||g' -e 's|".*$$||g' -e 's|/$$||g'); do grep -q $$i ${ABOUT} || echo "$$i (in ${OPML}, not in ${ABOUT})"; done

about-not-in-opml:
	@for i in $$(cat ${ABOUT} | egrep -v '(8thlight|thoughtbot|thoughtworks)' | grep '(http.*)$$' | sed -e 's|^.*](||g' -e 's|)$$||g' -e 's|/$$||g'); do grep -q $$i ${OPML} || echo "$$i (in ${ABOUT}, not in ${OPML})"; done
