From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Nov 2019 14:58:07 +0100
Subject: [LTP] [PATCH v3 2/2] Improve coverage in syscalls/fsync03
In-Reply-To: <20191031102116.10592-3-mdoucha@suse.cz>
References: <20191009152459.GB15291@rei.lan>
 <20191031102116.10592-1-mdoucha@suse.cz>
 <20191031102116.10592-3-mdoucha@suse.cz>
Message-ID: <20191107135807.GA24488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Both pushed, thanks.

I've did a minor change to the code so that we print TTERRNO in case of
the success to make the messages a bit more useful.

-- 
Cyril Hrubis
chrubis@suse.cz
