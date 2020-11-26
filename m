From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Nov 2020 16:03:49 +0100
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
In-Reply-To: <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
References: <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>
 <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
 <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
Message-ID: <20201126150349.GB4646@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm reluctant to use a static value here as max_msg_len may be modified
> by command line arguments.

Wouldn't it be easier to use malloc() instead of putting large data
structures on the stack and working around that by increasing the
limits?

-- 
Cyril Hrubis
chrubis@suse.cz
