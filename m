From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 16:58:45 +0100
Subject: [LTP] [PATCH 2/3] Port test_1_to_1_initmsg_connect (SCTP) to
 new API
In-Reply-To: <e896dee9-4a6d-e5e8-e98b-0fb59a81de77@suse.cz>
References: <20191126120241.5460-1-mdoucha@suse.cz>
 <20191126120241.5460-3-mdoucha@suse.cz>
 <20191213153933.GB8241@dell5510>
 <e896dee9-4a6d-e5e8-e98b-0fb59a81de77@suse.cz>
Message-ID: <20191213155845.GA13257@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> >> -	tst_resm(TPASS, "connect() with init timeout set to 0 - SUCCESS");
> >> +	if (TST_RET != msglen) {
> >> +		tst_res(TFAIL | TTERRNO, "recv() failed");
> >> +	} else {
> >> +		tst_res(TPASS, "connect() with init timeout set to 0 - SUCCESS");
> > If you don't mind, I'd remove " - SUCCESS" from the message before merge.

> Please do.

Thanks your patch!
Merged with this change and copyright in utils/sctp/func_tests/test_1_to_1_initmsg_connect.c

Kind regards,
Petr
