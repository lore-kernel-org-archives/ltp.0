From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jun 2018 16:12:12 +0200
Subject: [LTP] [PATCH v2 3/3] cve/cve-2018-1000001: Add Realpath Buffer
 Underflow test
In-Reply-To: <20180621141012.362aoktmiyfe5wjk@dell5510>
References: <20180620154843.27565-1-pvorel@suse.cz>
 <20180620154843.27565-3-pvorel@suse.cz>
 <20180621093419.GA22873@rei>
 <20180621141012.362aoktmiyfe5wjk@dell5510>
Message-ID: <20180621141211.GA14165@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I doubt that we need the cast to char* here.
> 
> We do:
> getcwd05.c: In function ???run???:
> ../../../../include/tst_test.h:53:40: warning: format ???%s??? expects argument of type ???char *???, but argument 5 has type ???void *??? [-Wformat=]
>   tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
> 
> So is something wrong in my TESTPTR() implementation?

Ah, okay my bad, so gcc is strict here (which makes sense).

-- 
Cyril Hrubis
chrubis@suse.cz
