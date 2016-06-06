From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jun 2016 17:46:10 +0200
Subject: [LTP] [PATCH V3-2 6/9] testcases/lib: Add tst_random decmical
 integer generator
In-Reply-To: <1462966591-3895-7-git-send-email-chuhu@redhat.com>
References: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
 <1462966591-3895-2-git-send-email-chuhu@redhat.com>
 <1462966591-3895-3-git-send-email-chuhu@redhat.com>
 <1462966591-3895-4-git-send-email-chuhu@redhat.com>
 <1462966591-3895-5-git-send-email-chuhu@redhat.com>
 <1462966591-3895-6-git-send-email-chuhu@redhat.com>
 <1462966591-3895-7-git-send-email-chuhu@redhat.com>
Message-ID: <20160606154609.GD21264@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static long rand_range(long min, long max)
> +{
> +	return rand() % (max - min + 1) + min;
> +}

I've changed this to use random() and srandom() instead of rand() and
srand(), since rand() and srand() are obsolete and moreover rand()
returns only int while the rest of the test uses long.

-- 
Cyril Hrubis
chrubis@suse.cz
