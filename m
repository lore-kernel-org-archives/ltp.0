From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Oct 2015 19:22:34 +0200
Subject: [LTP] [PATCH V4] controllers/cgroup_fj: split cgroup_fj tests
In-Reply-To: <1443686464-9965-1-git-send-email-chnyda@suse.com>
References: <1443686464-9965-1-git-send-email-chnyda@suse.com>
Message-ID: <20151001172234.GA30448@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +case $CASETYPE in
> +"function" )
> +	: $(( CASENO1 += 1 ))
> +	export CASENO1=$CASENO1
> +	./cgroup_fj_function.sh $CASECMD
> +	;;
> +"function2" )
> +	: $(( CASENO1 += 1 ))
> +	export CASENO1=$CASENO1
> +	./cgroup_fj_function2.sh $CASECMD
> +	;;
> +"stress" )
> +	: $(( CASENO2 += 1 ))
> +	export CASENO2=$CASENO2
> +	./cgroup_fj_stress.sh $CASECMD

I've removed the './' here (since /opt/ltp/testcases/bin/ is in $PATH
while tests are running) and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
