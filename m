From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jan 2019 18:27:27 +0100
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost.c: skip test if
 turbo is disabled by BIOS or unavailable on processor
In-Reply-To: <20190108112737.GA25178@x230>
References: <1546852515-19045-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190108093344.GA2687@x230> <5C347181.8080303@cn.fujitsu.com>
 <cd870461-e84f-d16a-0621-f3466fd59f32@arm.com>
 <20190108112737.GA25178@x230>
Message-ID: <20190123172727.GA18294@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> > I could be wrong but i think that if you keep the string unsplitted and move it
> > on its own line checkpatch.pl should be fine, like in:

> > tst_brkm(TCONF, NULL,
> >          "Turbo is disabled by BIOS or unavailable on processor");
> Yes.

> Xiao, no need to repost patch, this can be done during merge.
Merged with unsplitted string change.

Thanks for your work.


Kind regards,
Petr
