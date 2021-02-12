From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Feb 2021 16:15:09 +0100
Subject: [LTP] [PATCH 2/2] mq_timedreceive_5-3: Fix test for timestamp
 after INT32_MAX
In-Reply-To: <54607759-e48f-0a45-fab8-5d07ec32f004@jv-coder.de>
References: <20210203074520.18401-1-lkml@jv-coder.de>
 <20210203074520.18401-2-lkml@jv-coder.de>
 <54607759-e48f-0a45-fab8-5d07ec32f004@jv-coder.de>
Message-ID: <YCabfZtfQdFDFxiw@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Good catch, I've removed trailing whitespaces from the first patch and
pushed both, thanks.


-- 
Cyril Hrubis
chrubis@suse.cz
