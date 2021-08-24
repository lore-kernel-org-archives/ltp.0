From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 10:48:22 +0200
Subject: [LTP] [PATCH 1/3] tst_test_macros: Fix TST_EXP_*() default
 message
In-Reply-To: <CAEemH2dYcF=N3F=MZXPVLgBHBa3Xt=iT8ACeQ4_9THXu-kyYtA@mail.gmail.com>
References: <20210823150520.25614-1-chrubis@suse.cz>
 <20210823150520.25614-2-chrubis@suse.cz>
 <CAEemH2dYcF=N3F=MZXPVLgBHBa3Xt=iT8ACeQ4_9THXu-kyYtA@mail.gmail.com>
Message-ID: <YSSyVtSF6UmqYlu4@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Patchset looks good from the code layer though it is a bit complicate
> in 2/3 stringify handling, but that should be acceptable.
> 
> My only hesitating is about ##__VA_ARGS__, because it says that is still
> as GNU's extension but have not got into standard C.

Note that we have been using it in the header from the start. There were
just a few places where it was missing, mostly in the variants that have
been added later.

-- 
Cyril Hrubis
chrubis@suse.cz
