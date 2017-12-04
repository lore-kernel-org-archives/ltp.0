From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Dec 2017 18:15:11 +0100
Subject: [LTP] [RFC PATCH v3 1/5] travis: Add build script and use it in
 travis
In-Reply-To: <20171204122553.15338-2-pvorel@suse.cz>
References: <20171204122553.15338-1-pvorel@suse.cz>
 <20171204122553.15338-2-pvorel@suse.cz>
Message-ID: <20171204171510.GE21055@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Hi!
> +	cd $build
> +	if ! $tree/configure $CONFIGURE_OPTS; then
> +		echo "== ERROR: configure failed, config.log =="
> +		cat config.log
> +		exit 1
> +	fi
> +
> +	echo "== config.log =="
> +	cat config.log

I find this output to be a bit too verbose, frankly I do not remeber
checking it content of the config.log ever.

> +    make $make_opts
> +    make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
   ^
   Here you use spaces instead of tabs.

> +}
> +
> +build_in_tree()
> +{
> +	echo "=== autotools ==="
> +	make autotools
> +
> +	echo "=== configure ==="
> +	if ! ./configure $CONFIGURE_OPTS_IN_TREE $@; then
> +		echo "== ERROR: configure failed, config.log =="
> +		cat config.log
> +		exit 1
> +	fi
> +
> +	echo "== config.log =="
> +	cat config.log

Here as well.

> +	echo "=== build ==="
> +	make $MAKE_OPTS
> +
> +	echo "=== install ==="
> +	make $MAKE_OPTS install
> +}
> +
> +usage()
> +{
> +	cat << EOF
> +Usage:
> +$0 [ BUILD_TYPE ]
> +$0 -h|--help|help
> +
> +Options:
> +-h|--help|help  Print this help
> +
> +BUILD TYPES:
> +32      32-bit in-tree build
> +native  native in-tree build
> +out     out-of-tree build
> +
> +Default build is native in-tree build.
> +EOF
> +}
> +
> +case "$1" in
> +	-h|--help|help) usage; exit 0;;
> +	32) build="build_32";;
> +	out) build="build_out_tree";;
> +	*) build="build_native";;
> +esac
> +
> +cd `dirname $0`
> +$build
> +
> +# vim: set ft=sh ts=4 sts=4 sw=4 noet:

I prefer not to clobber source code with this kind of editor hints.

-- 
Cyril Hrubis
chrubis@suse.cz
