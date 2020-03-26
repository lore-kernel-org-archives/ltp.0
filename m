From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 13:48:22 +0100
Subject: [LTP] [PATCH] Add test for CVE 2018-1000199
In-Reply-To: <117b0eb0-984b-eb95-b65e-e92c9a206a95@suse.cz>
References: <20200319162114.3967-1-mdoucha@suse.cz>
 <20200326055639.GA5206@dell5510> <20200326063638.GB5206@dell5510>
 <117b0eb0-984b-eb95-b65e-e92c9a206a95@suse.cz>
Message-ID: <20200326124822.GA27616@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> > On some machines I got TBROK, but we probably cannot avoid it. 
> > ptrace08.c:119: BROK: Received unexpected event from child

> Hmm, could you apply the following patch and send me the output from
> those machines?
Sure. On TBROK child received SIGKILL signal (whereas SIGTRAP on TPASS).

NOTE: if I include <sys/wait.h> to get WCOREDUMP obviously it's not
WCOREDUMP(status).

Kind regards,
Petr
