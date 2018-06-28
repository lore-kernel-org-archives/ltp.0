From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Jun 2018 15:59:05 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix check for $TST_DEVICE
In-Reply-To: <20180628122944.3373-1-pvorel@suse.cz>
References: <20180628122944.3373-1-pvorel@suse.cz>
Message-ID: <939320688.29608276.1530215945657.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> When tst_device acquire call fails, it outputs into stdout,
> therefore the content is actually help message.
> => Check for file presence rather than variable not being empty.
> 
> Fixes: c5ac5d712 tst_test.sh: Make use of tst_device helper
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Good find, ACK

> ---
> Hi,
> 
> other option would be to check $?.

Or both. Attach is very last call to ioctl(), so I think
we can't end up with valid block device and non-zero retcode.
