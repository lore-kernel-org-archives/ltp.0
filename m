From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Feb 2020 11:32:57 +0100
Subject: [LTP] [PATCH V3 00/10] Add new LTP tests related to fsmount
 family of syscalls
In-Reply-To: <CAEemH2dogCkDHtZzwWCx-ahg-CebGYLNyew6F2AkJVPC_yivBA@mail.gmail.com>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <CAEemH2dogCkDHtZzwWCx-ahg-CebGYLNyew6F2AkJVPC_yivBA@mail.gmail.com>
Message-ID: <20200225103257.GA64607@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Patch 5/10, 9/10:
> May I ask why we use "sync" as the key value in fsconfig()? I ask this
> because it can get rid of the errors we found in XFS test before.
I guess "sync" is valid option (see FILESYSTEM-INDEPENDENT MOUNT OPTIONS
in mount(8)), but "foo" obviously not.

> Patch 9/10, 10/10:
> I guess that'd be better if we put the 'ismounted = 1' at the behind of
> tst_is_mounted(), do you feel the code sequence looks strange which we set
> 'ismounted' to 1 then do mount checking?
+1.

Kind regards,
Petr
