From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Mar 2018 08:07:00 +0200
Subject: [LTP] [PATCH] setregid: use common user and group names.
In-Reply-To: <20180327172440.GM72541@sspatil-desktop.mtv.corp.google.com>
References: <20180319200113.106692-1-sspatil@google.com>
 <20180326124200.GA311@x230>
 <20180326192956.GL72541@sspatil-desktop.mtv.corp.google.com>
 <20180327094313.b6vetum2xitabi5u@dell5510>
 <20180327172440.GM72541@sspatil-desktop.mtv.corp.google.com>
Message-ID: <20180328060700.GA25695@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

...
> > > Also, I wouldn't worry about the test breaking on slightly older Android. The
> > > vast majority of LTS tests are run through VTS, where these tests were disabled[1]
> > > due to the failure anyway. This change will allow us to start running them on
> > > all android devices now onwards ..

> > I thought that there could be preprocesor condition for Android defining different users
> > for it, but if you don't need it I'll merge it.

> Yes, we can probable ifdef it in one place using "#ifdef __ANDROID__" or
> other equivalent, but I don't think its needed here. We want to avoid doing
> that as much as possible. It is fair to say these test will be run with VTS
> "now onwards" anyway ..
Thanks for explanation. I agree, makes sense to avoid it where possible.

> > and just note your related commit in commit
> > message:
> > 8e8648463 ("libcutils: Add "daemon" and "bin" users for testing only")

> I'll resend the patch with this added, thanks for the review.
I'm sorry I've added it myself yesterday and pushed:
1b7cf9474 setregid: use common user and group names.

I'll be more patient next time.


> - ssp

Kind regards,
Petr
