From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Mar 2020 11:33:56 +0100
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <20200325102852.GD5404@yuki.lan>
References: <20200324121742.7130-1-gengcixi@gmail.com>
 <20200325102852.GD5404@yuki.lan>
Message-ID: <20200325103356.GE5404@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Also looking at the serialtest.c source code, it's just a few lines that
haven't been changed since 2014, so it may be just easier to write a C
testcase based on that code and would avoid dependency on third party
git repository that way as well.

-- 
Cyril Hrubis
chrubis@suse.cz
