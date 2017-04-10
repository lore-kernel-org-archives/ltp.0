From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 13:33:22 +0200
Subject: [LTP] [RFC] [PATCH] lib: Fix undefined reference to `mq_open'
 build failures
In-Reply-To: <871439500.24205435.1491810104946.JavaMail.zimbra@redhat.com>
References: <20170329165008.6396-1-chrubis@suse.cz>
 <20170406074544.GA18057@rei.lan> <20170407155222.GA9310@rei>
 <871439500.24205435.1491810104946.JavaMail.zimbra@redhat.com>
Message-ID: <20170410113322.GA23301@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > * Anything else?
> 
> Move safe_mq_open to header?

I guess that I missed the obviously easiest solution. I will commit a
change that moves the functio to the header.

-- 
Cyril Hrubis
chrubis@suse.cz
