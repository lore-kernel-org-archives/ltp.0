From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 31 Jan 2020 04:45:19 -0500 (EST)
Subject: [LTP] [PATCH 4.14 00/46] 4.14.169-stable review
In-Reply-To: <CA+G9fYvMc73OCXNz_9Ks-GqE828Vd3YFeX_iOrWq3bobGpgUtQ@mail.gmail.com>
References: <20200128135749.822297911@linuxfoundation.org>
 <CA+G9fYsnSGw0NmV5hWwZSs5OYu18YRam3jYCsg4Sn+KUQJSMWw@mail.gmail.com>
 <1680515224.4725561.1580289411736.JavaMail.zimbra@redhat.com>
 <CA+G9fYvMc73OCXNz_9Ks-GqE828Vd3YFeX_iOrWq3bobGpgUtQ@mail.gmail.com>
Message-ID: <1480601816.5094241.1580463919045.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, 29 Jan 2020 at 14:46, Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> >
> > ----- Original Message -----
> > > NOTE:
> > > LTP fs test read_all_proc fails intermittently on 4.9 and 4.14 branches.
> >
> > [trim CC list to LTP]
> >
> > Naresh, do you have some examples of these failures?
> 
> Yes.
> I have posted the links below.
> 
> > Has it started recently or do you see it long-term?
> 
> We have seen this from a this test is introduced.
> Not specific to any branch. This failure is intermittent and found on
> multiple trees and branches.

Those look like kernel bugs, but it's hard to see what /proc entries
trigger it.

I've been running v5.5 and read_all_proc for ~24 hours on aarch64,
but so far no crashes.

