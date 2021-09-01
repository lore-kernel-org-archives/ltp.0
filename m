From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Sep 2021 20:14:48 +0200
Subject: [LTP] [PATCH v5 2/3] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <20210901151655.95760-2-krzysztof.kozlowski@canonical.com>
References: <20210901151655.95760-1-krzysztof.kozlowski@canonical.com>
 <20210901151655.95760-2-krzysztof.kozlowski@canonical.com>
Message-ID: <YS/DGPyHmEHnRSZk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +check_limits()
> +{
> +	local tasksneeded=$((max * nbprocess + 100))

We allready have some reserve for the system in the tst_get_free_pids()
so shouldn't this be just max * nbprocess ?


-- 
Cyril Hrubis
chrubis@suse.cz
