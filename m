From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Feb 2020 09:05:58 +0100
Subject: [LTP] [PATCH v2 1/3] Redesign TST_RETRY_FUNC()
In-Reply-To: <0090dabb-76fa-ea3d-2f96-4c4e50146bba@suse.cz>
References: <20200207112236.16462-1-mdoucha@suse.cz>
 <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <0090dabb-76fa-ea3d-2f96-4c4e50146bba@suse.cz>
Message-ID: <20200218080558.GA19384@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> On 2/8/20 7:35 AM, Li Wang wrote:
> > 1. We need to update the doc/test-writing-guidelines.txt?too.

> Right. I'll resubmit in a moment.
Thanks!

> > 2. Maybe better to let the shell version is consistent with this new?

> That doesn't make much sense. Shell programs and functions have much
> simpler call conventions than C functions. If you really need to test a
> more complex result than a single return value in shell, writing a
> wrapper function is much easier than writing a validator function.

> In C, it's the other way around. Writing a wrapper function would often
> be a ton of work compared to writing a simple retval validator macro.
+1.


Kind regards,
Petr
