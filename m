From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Aug 2021 08:36:08 +0200
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <610B5E7D.1070104@fujitsu.com>
References: <20210712075223.10682-2-aleksei.kodanev@bell-sw.com>
 <YPkkZ0Zq9DyHKBaT@pevik> <YPlhMeRRsNnemT05@yuki>
 <YPlsK8fsMI8T+H7c@pevik> <YPlsVD2gbIiX8JJk@yuki>
 <60FA81E4.3060709@fujitsu.com> <YPq0749ZnnGsAV2q@pevik>
 <60FF9EFA.308@fujitsu.com> <YQqor4LiNK4/Xrbe@yuki>
 <610B5E7D.1070104@fujitsu.com>
Message-ID: <YQuG2CllvzVqdw8L@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> >> -	if (used_queues<  0) {
> >> -		tst_brk(TBROK, "can't read /proc/sysvipc/msg to get "
> >> -			"used message queues at %s:%d", file, lineno);
> >> +	if (used_cnt<  0) {
> >> +		tst_brk(TBROK, "can't read %s to get used message queues "
> >> +			"at %s:%d", sysvipc_file, file, lineno);
> >>   	}
> I also modify this info.
> message queues => sysvipc resource total
+1. nit: I'd also move "at" at the previous line (better for grep).

Kind regards,
Petr

