From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Aug 2021 13:35:16 +0200
Subject: [LTP] [PATCH v7 1/7] lib: Print Summary: into stderr
In-Reply-To: <YQkMuOHjZ4HHO+QQ@yuki>
References: <20210802173536.19525-1-pvorel@suse.cz>
 <20210802173536.19525-2-pvorel@suse.cz> <YQkMuOHjZ4HHO+QQ@yuki>
Message-ID: <YQkp9AP+fblqnXzI@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> I wonder if this change can break anything but I guess that it's
> unlikely.

> Also while you are at it can you also fix tags? We do print help() to
> stderr but tags that follow go into stdout which is rather starnge.

> And the failure hints are written to stdout as well, which should be
> fixed as well.

Sure, I'll fix them all in v8.

Kind regards,
Petr
