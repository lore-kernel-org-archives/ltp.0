From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 12:01:46 +0200
Subject: [LTP] Test library API changes
In-Reply-To: <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
 <20160314125153.GB600@rei.lan> <20160314160036.GA2511@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan> <20160317160606.GA31815@rei.lan>
 <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
Message-ID: <20160331100146.GA20485@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Latest version is at usuall place:

https://github.com/metan-ucw/ltp

Now rest of the library calls should be wired to the new library as
well, see for example this header:

https://github.com/metan-ucw/ltp/blob/master/include/tst_fs.h

The documentation was updated as well (I've even added a few functions
that were not documented previously).

I've also compared build logs to make sure that the changes haven't
introduced new warnings and did a few syscall testruns to make sure
everything works fine. Both looks good to me.

We are not that far from next LTP release. As a matter of fact we should
start preparing for it anytime soon. Ideally I would like to get this
merged before the release freeze and testing. What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
