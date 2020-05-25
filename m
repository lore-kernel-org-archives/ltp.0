From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 May 2020 18:28:39 +0200
Subject: [LTP] [PATCH v2 3/3] Add test for CVE 2017-1000111
In-Reply-To: <f24e98c8-0aba-aaeb-0401-dafe2fffa897@suse.cz>
References: <20200505152315.29216-1-mdoucha@suse.cz>
 <20200505152315.29216-3-mdoucha@suse.cz>
 <20200525141510.GC26837@dell5510>
 <f24e98c8-0aba-aaeb-0401-dafe2fffa897@suse.cz>
Message-ID: <20200525162839.GA18169@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> > Don't we want to add here taint check (you had it in v1)?
> > tst_taint_init(TST_TAINT_W | TST_TAINT_D);

> Taint check is meaningless in this test because the only ill effect from
> the race condition is that all incoming packets will be truncated to 0
> bytes. Somebody would have to horribly break the code for receiving
> incoming packets in order to turn this bug into something that can
> actually taint the kernel.

Right, that makes no sense to add it then.
Thanks for explanation and your patchset, merged.

Kind regards,
Petr
