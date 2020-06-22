From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jun 2020 10:53:27 +0200
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: Print tst_{res,
 brk} into stdout
In-Reply-To: <20200619192542.20113-1-pvorel@suse.cz>
References: <20200619192542.20113-1-pvorel@suse.cz>
Message-ID: <20200622085327.GA2389@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This allows printing messages on functions which output is redirected
> into variable or used in eval. Also this change unifies the behavior
> with C new API, which printed into stderr from the beginning.

The patch looks fine but the first line and the email subject should say
stderr, right?

-- 
Cyril Hrubis
chrubis@suse.cz
