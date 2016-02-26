From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Fri, 26 Feb 2016 10:25:18 +0800
Subject: [LTP] [PATCH] mem/oom: call WEXITSTATUS() only if WIFEXITED()
 returned true
In-Reply-To: <568467929.36937.1456386392891.JavaMail.zimbra@redhat.com>
References: <20160224101914.GA4402@localhost.localdomain>
 <1952284603.26737557.1456311806125.JavaMail.zimbra@redhat.com>
 <20160225011819.GB4402@localhost.localdomain>
 <568467929.36937.1456386392891.JavaMail.zimbra@redhat.com>
Message-ID: <20160226022518.GC4402@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Feb 25, 2016 at 02:46:33AM -0500, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp@lists.linux.it
> > Sent: Thursday, 25 February, 2016 2:18:19 AM
> > Subject: Re: [LTP] [PATCH] mem/oom: call WEXITSTATUS() only if WIFEXITED() returned true
> > 
> > On Wed, Feb 24, 2016 at 06:03:26AM -0500, Jan Stancek wrote:
> > > Is this only theoretical or did you actually run into this?
> > > If so, what are the circumstances for this to happen?
> > 
> > It is only theoretical. I composed this only based on code reading.
> > 
> > Thanks.
> 
> I fixed one line going over 80 characters and pushed it.
> 
Thanks!

