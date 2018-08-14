From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Aug 2018 18:22:25 +0200
Subject: [LTP] [PATCH v2] execve: rewrite to newlib
In-Reply-To: <20180809052926.27360-1-liwang@redhat.com>
References: <20180809052926.27360-1-liwang@redhat.com>
Message-ID: <20180814162225.GA23451@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor adjustments, thanks.

Apart from simple formatting fixed (removed trailing whitespace) I've
removed needs_root from execve04 and changed exeve_child.c to check for
argc > 1 in case that we do strcmp() othewise the child will segfault
when executed without parameters.

-- 
Cyril Hrubis
chrubis@suse.cz
