From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Mar 2019 09:32:10 +0100
Subject: [LTP] [PATCH v2] setpriority01: Skip only PRIO_USER when unable
 to add test user
In-Reply-To: <20190307233154.12873-1-saravanak@google.com>
References: <20190307233154.12873-1-saravanak@google.com>
Message-ID: <20190319083210.GB26794@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Saravana,

> We don't need to skip all the tests just because we are unable to add
> a test user. Not having a test user only affects PRIO_USER test case.
> So just skip that one and continue running the rest of the tests when
> useradd is not available.

> If useradd is present and it still fails, then consider it an error in
> the test preparation phase.

> This also allows this test case to be built and run on Android.

> Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> v2:
> - Skip only PRIO_USER test when useradd isn't present
> - Fail entire test with TBROK for all other cases where user can't be added

> I still think v1 is the right approach. But if you want TCONF for only
> for cases like Android where useradd itself isn't present, then v2 would
> be the right patch.
Agree with it, but waiting for Cyril approval to merge it.

Kind regards,
Petr
