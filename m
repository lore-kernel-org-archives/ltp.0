From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Aug 2020 14:53:57 +0200
Subject: [LTP] [PATCH] selftests: vdso: hash entry size on alpha,
 s390x is 8 bytes
In-Reply-To: <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
 <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
Message-ID: <20200805125357.GE5522@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As much as it's worth the changes looks good to me.

@Jan: I guess that we can as well fix this in LTP first then we can try
      to get the kernel version fixed...

-- 
Cyril Hrubis
chrubis@suse.cz
