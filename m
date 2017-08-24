From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Aug 2017 11:55:59 +0200
Subject: [LTP] [PATCH] [dynamic debug] - Check interface and
	functionality
In-Reply-To: <2042543057.655418.1503511658187.JavaMail.zimbra@redhat.com>
References: <20170822102244.6266-1-vkabatov@redhat.com>
 <20170822130953.GA23381@rei.lan>
 <2042543057.655418.1503511658187.JavaMail.zimbra@redhat.com>
Message-ID: <20170824095559.GB28956@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm not convinced using EXPECT_* would be the same since I only want
> to report failures and these functions report both TPASS and TFAIL.
> On my machine, this setup produces additional 16k of not that useful
> lines (if something fails, you are still notified about it and know
> every line before it passed). Of course if you can think of a use case
> where having reports for every passed line would make sense I can do
> this change.

Right, haven't thought of that, yes adding 16k of useless output is not
something we want to do.

We may as well add EXPECT_PASS_SILENT or keep the code as it is...

-- 
Cyril Hrubis
chrubis@suse.cz
