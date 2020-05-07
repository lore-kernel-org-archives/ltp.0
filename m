From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 May 2020 16:31:42 +0200
Subject: [LTP] [PATCH] pty04: Correct struct member sizes and add to CVE
 runtest file
In-Reply-To: <20200507141142.GA19567@yuki.lan>
References: <20200506170407.5562-1-rpalethorpe@suse.com>
 <20200506171921.GA1214@dell5510>
 <CAEemH2eQ9Dd4CewEvPxfZx-1R69QS990iodR1_EsbYBVX8TmyA@mail.gmail.com>
 <20200507141142.GA19567@yuki.lan>
Message-ID: <20200507143142.GA24733@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Hi!
> > nit: I might separate runtest change into it's own commit.

> Agree here, the runtest change should be separated.
+1.

Merged, thanks for a fix!

We still have time to comment out the test if #674 won't be fixed before
release.

Kind regards,
Petr

https://github.com/linux-test-project/ltp/issues/674
