From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Apr 2018 03:20:51 -0400 (EDT)
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426164928.6c86604e@linux-p5n0>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426164928.6c86604e@linux-p5n0>
Message-ID: <1448033218.16051780.1524813651315.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> Honestly I just wanted to pick your brain and ask community what's the
> best approach for commands testing.
> 
> One might also say - better leave them there and do not run them if you
> are not happy with it. Sure.
> 
> So really over to community and maintainers to advise what would be the
> best approach here.

I'd go one by one. For those that are broken, propose them to be removed
and CC people who touched it in last ~2-3 years.

@Li: Does ltp/general run all commands? Are there failures?

Regards,
Jan
