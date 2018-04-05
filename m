From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Apr 2018 19:15:59 +0200
Subject: [LTP] [RFC PATCH v5 1/6] tst_net.sh: Support both new and
 legacy APIs + rename
In-Reply-To: <20180405133024.2279-2-pvorel@suse.cz>
References: <20180405133024.2279-1-pvorel@suse.cz>
 <20180405133024.2279-2-pvorel@suse.cz>
Message-ID: <20180405171559.lhvjouc44txrbfsj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> The new name states that library supports new API.
...
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

> +lib_params=
>  while getopts "hl:m:p:s:S:k:A:e:a:c:r:6" opt; do
>  	case "$opt" in
>  	h)
> @@ -63,11 +62,14 @@ while getopts "hl:m:p:s:S:k:A:e:a:c:r:6" opt; do
>  	a) AALGO=$OPTARG ;;
>  	c) CALGO=$OPTARG ;;
>  	r) IPSEC_REQUESTS="$OPTARG" ;;
> -	6) # skip, test_net library already processed it
> -	;;
> +	6) lib_params="-6" ;;
>  	*) tst_brkm TBROK "unknown option: $opt" ;;
>  	esac
>  done
> +shift $(($OPTIND - 1))
> +
> +TST_USE_LEGACY_API=1
> +. tst_net.sh $lib_params
This is a bashism. I've already fixed that with scripts using getopt:
-	6) # skip, test_net library already processed it
-	;;
+	6) TST_IPV6=6 ;;

And then in tst_net.sh:
+# Blank for an IPV4 test; 6 for an IPV6 test.
+TST_IPV6=${TST_IPV6:-}

And fixed:
* missing $ipver in multicast tests
* broken creating tmpdir on rhost in new API

Kind regards,
Petr
