From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 09:18:19 +0800
Subject: [LTP] [PATCH] mem/oom: call WEXITSTATUS() only if WIFEXITED()
 returned true
In-Reply-To: <1952284603.26737557.1456311806125.JavaMail.zimbra@redhat.com>
References: <20160224101914.GA4402@localhost.localdomain>
 <1952284603.26737557.1456311806125.JavaMail.zimbra@redhat.com>
Message-ID: <20160225011819.GB4402@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 24, 2016 at 06:03:26AM -0500, Jan Stancek wrote:
> Is this only theoretical or did you actually run into this?
> If so, what are the circumstances for this to happen?

It is only theoretical. I composed this only based on code reading.

Thanks.

