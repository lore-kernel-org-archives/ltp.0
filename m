From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Dec 2017 13:59:52 +0100
Subject: [LTP] [PATCH] runltp: skipfile: skipped test cases should be
 visible as TCONF in results
In-Reply-To: <1513073830-17174-1-git-send-email-naresh.kamboju@linaro.org>
References: <1513073830-17174-1-git-send-email-naresh.kamboju@linaro.org>
Message-ID: <20171219125952.GE28293@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +    if [ -n "${SKIPFILE}" ]; then
> +        while read -r test_line; do
> +            case "${test_line}" in \#*) continue ;; esac
> +            if [ -n "${test_line}" ]; then
> +                # test_name is first column of each line in SKIPFILE
> +                test_name=$(echo ${test_line} | awk '{print $1}')
> +                sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
> +            fi
> +        done < ${SKIPFILE}

This could be written in a simpler form:

	for test_name in $(awk '{print $1}' "$SKIPFILE"); do
		case "${test_name}" in \#*) continue;; esac
		sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
	done


Other than that it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
