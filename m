From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Oct 2015 17:29:00 +0200
Subject: [LTP] [PATCH v2] syscalls/setregid02: Fix retrieving a group of
 user "nobody"
In-Reply-To: <1444139373-12321-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1444139373-12321-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20151006152900.GA29605@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -static struct group nobody, root, bin;
> +static struct group ltpgroup, root, bin, *junk;

I've changed the newly introduced function so that they use local
variable instead of global one and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
