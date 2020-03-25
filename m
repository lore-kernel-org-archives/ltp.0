From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Mar 2020 15:19:44 +0100
Subject: [LTP] [PATCH] Fix use after stack unwind in fzsync lib
In-Reply-To: <875zeszglp.fsf@our.domain.is.not.set>
References: <20200325103734.31295-1-mdoucha@suse.cz>
 <875zeszglp.fsf@our.domain.is.not.set>
Message-ID: <20200325141944.GA4021@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >         pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> >         pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > -       return t.func(t.arg);
> > +       ret = t->func(t->arg);
> > +       free(t);
> 
> Why not use SAFE_FREE?

free() does not report errors, there is no such thing as SAFE_FREE()

-- 
Cyril Hrubis
chrubis@suse.cz
