From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Aug 2019 15:08:02 +0200
Subject: [LTP] [PATCH 1/2] runtest/syscalls: add set_mempolicy*
In-Reply-To: <5D68F179.3000402@cn.fujitsu.com>
References: <1566987255-3010-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190829203826.GA5711@dell5510> <5D688449.3080906@cn.fujitsu.com>
 <5D68F179.3000402@cn.fujitsu.com>
Message-ID: <20190830130801.GA27587@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > PS: If someone want to run syscalls from LTP as many as possible, they
> > just need to run syscalls group directly.
> +1 , set_mempolicy syscall should belong to numa and syscall group.
OK, merged. + I sorted them properly, with other set_* tests in that commit.

Kind regards,
Petr
