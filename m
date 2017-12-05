From: Eric Biggers <ebiggers@google.com>
Date: Tue, 5 Dec 2017 10:10:47 -0800
Subject: [LTP] 3239b6f29b ("KEYS: return full count in keyring_read() if
 buffer is too small"): ltp.keyctl06.fail
In-Reply-To: <87a7yxmrwz.fsf@rpws.prws.suse.cz>
References: <20171201024012.wsq3xnsbbdqwxwp2@wfg-t540p.sh.intel.com>
 <20171201192152.GD142348@google.com>
 <87a7yxmrwz.fsf@rpws.prws.suse.cz>
Message-ID: <20171205181047.GA66710@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 05, 2017 at 10:43:08AM +0100, Richard Palethorpe wrote:
> 
> We are getting the following result, even with the follow up patch:
> 
> keyctl06.c:68: FAIL: KEYCTL_READ returned 4 but expected 8
> 
> This is with SUSE SLE15 kernel 4.12.14. I haven't had chance to
> investigate it yet.
> 

Does the kernel include *both* fixes the test tests for now?
