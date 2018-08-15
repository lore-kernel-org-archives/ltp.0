From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Aug 2018 12:50:09 +0200
Subject: [LTP] [PATCH] pty: using tcgetattr() to get attributes before
 re-setting it
In-Reply-To: <CAEemH2fr-5HAJdFL_Br7u2bsry5E3j_dwaVnnJFdm4wFTWsA0w@mail.gmail.com>
References: <20180528103936.22538-1-liwang@redhat.com>
 <5B0CFB5C.5040702@cn.fujitsu.com>
 <CAEemH2fr-5HAJdFL_Br7u2bsry5E3j_dwaVnnJFdm4wFTWsA0w@mail.gmail.com>
Message-ID: <20180815105009.GA1379@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I'm looking into these patches now, so if I get it right we should:

* Add EXTPROC into lapi
* Get the termios value, or it with the requested flags, then apply
  tcsetattr()
* Exit the test with TCONF if we get EINVAL from tcsetattr()

Would that work for both of you?

-- 
Cyril Hrubis
chrubis@suse.cz
