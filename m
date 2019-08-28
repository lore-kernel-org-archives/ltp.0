From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 28 Aug 2019 13:58:08 +0200
Subject: [LTP] [PATCH v3 1/2] capability: Introduce capability API
In-Reply-To: <CAEemH2dVf66_sKT4iBSEOXg+yFhpL7mAp4Uar5OT6vmbiMa0ZQ@mail.gmail.com>
References: <20190823094621.21747-1-rpalethorpe@suse.com>
 <CAEemH2dVf66_sKT4iBSEOXg+yFhpL7mAp4Uar5OT6vmbiMa0ZQ@mail.gmail.com>
Message-ID: <871rx5mrhr.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

>> The capability will be dropped in between 'setup' and 'run'.
>
> I'm not sure to put this cap function behind 'setup' is a better
> choice.
>
> Although it provides more capability in different test phase and makes
> test flexible, that also involves more complexity for LTP users,
> sometimes test needs to spawn children in the 'setup' and do more
> testing in next 'run' phase, which obviously makes us have to consider
> more in this case writing.

Children will need to drop and check for privs themselves anyway unless
one uses ambient privileges (which I guess could still be overriden by
the environment).

Maybe it would make sense to check for privileges before setup. However
I can't think of a situation where one would want to drop them before
setup. Meanwhile it seems likely that setup requires privs, but the test
should not have them.

>
> Anyway, the patchset looks good. We can do some improvements in real
> situations then.
>
>     Acked-by: Li Wang <liwang@redhat.com>


--
Thank you,
Richard.
