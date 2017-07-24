From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Jul 2017 10:46:33 +0200
Subject: [LTP] [PATCH] network/stress: Reduce the default number of
 cycles for various tests
In-Reply-To: <6f6abb62-d010-0919-a9b3-61c0f5c8477a@oracle.com>
References: <20170626082935.2868-1-pvorel@suse.cz>
 <6f6abb62-d010-0919-a9b3-61c0f5c8477a@oracle.com>
Message-ID: <20170724084633.aymvx2vcfjknfgjn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> >  # network/stress tests require additional parameters
> >  export NS_DURATION="${NS_DURATION:-3600}"

> What about changing NS_DURATION as well? If I remember correctly
> it's one hour for each test-case in 'Application' & 'broken_ip'
> groups.

I agree. How about changing it to 720?

I repeated this commit to my 7th version of "Simplify network setup + fix some network
stress tests" patchset [1]. If this is the only change in this patchset, could you please
change the value of NS_DURATION yourself? (There probably will be some changes, so I'll
fix it myself. But just in case to prevent me send v8 if there is no change).


Kind regards,
Petr

[1]: http://lists.linux.it/pipermail/ltp/2017-July/005075.html
