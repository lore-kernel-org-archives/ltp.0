From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 20 May 2021 09:13:56 +0100
Subject: [LTP] [PATCH 3/6] API/cgroups: Check for unknown controller name
In-Reply-To: <YKT0gqiSkeGdRt8w@yuki>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-4-rpalethorpe@suse.com> <YKT0gqiSkeGdRt8w@yuki>
Message-ID: <87a6oplt4r.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> So as far as I can tell this only shuffles code around but the
> functionality is the same since we moved the controller check from the
> tst_cgroup_ver() and tst_cgroup_require() to a common function.
>
> I'm not sure that this is worth the trouble.

It causes tst_brk to be called when the controller name is not found
instead of a null deref.

Although it may not be worth creating the function because tst_brk can
return as far as the compiler is concerned (although tst_require should
never be called from cleanup context). So I need to look at this again.

-- 
Thank you,
Richard.
