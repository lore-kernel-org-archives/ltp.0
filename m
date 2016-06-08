From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 11:48:03 +0200
Subject: [LTP] [PATCH 3/3] lib/tst_test.c: Kill all children on timeout
In-Reply-To: <669820651.4512952.1465374182489.JavaMail.zimbra@redhat.com>
References: <20160607124506.GA4236@rei.lan>
 <669820651.4512952.1465374182489.JavaMail.zimbra@redhat.com>
Message-ID: <20160608094803.GB8483@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ACK.
> 
> Is there a 2/3? I can't seem to find the series this patch belongs to.
> I assume 1/3 was "lib/tst_test.c: Run test in child process".

I should have deleted the 3/3 in order to make it less confusing.

The 2/3 would have been the SAFE_SETPGID() patch that I deemed to be
obvious enough to be commited directly.

-- 
Cyril Hrubis
chrubis@suse.cz
