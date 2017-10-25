From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Oct 2017 17:01:25 +0800
Subject: [LTP] [PATCH] ltp: keep the .tid hidden in the test library
In-Reply-To: <20171025081150.11206-1-liwang@redhat.com>
References: <20171025081150.11206-1-liwang@redhat.com>
Message-ID: <CAEemH2ekrPr8OJAwKP4Zog+M1xNCR7wqW-QBt-6AOUiCxbMWPQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Attaching a new patch to achieve the same target in another way. It
just remove the .tid from test struct and take use of TCID to replace.

Which one do you think is better?


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ltp-remove-.tid-from-test-struct.patch
Type: text/x-patch
Size: 9335 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171025/5b7a073b/attachment-0001.bin>
