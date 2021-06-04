From: Enji Cooper <yaneurabeya@gmail.com>
Date: Fri, 4 Jun 2021 10:47:30 -0700
Subject: [LTP] [RFC] Reduce LICENCE/COPYING files
In-Reply-To: <YLn3BQHhZIq5vNId@pevik>
References: <YLeA8KOphpVg3IDP@pevik> <YLi3XqA3hLh7HWqn@yuki>
 <YLjDnXeWib2KSILF@pevik>
 <CAEemH2dTBbHbh5Vf9EQyYMsvHKs3p4sZvoNyR=uCFM0X5siYtQ@mail.gmail.com>
 <YLn3BQHhZIq5vNId@pevik>
Message-ID: <3F3FDAE9-7190-4046-9438-17D2BE14FCA0@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I?d actually exercise some caution here. If there was a top-level LICENSE file that was distributed, that would be awesome, but if people take bits and pieces of subprojects and hack it in elsewhere without there being appropriate attributions to the original authors and such, you could get into serious legal trouble.

Doing the ?right thing? requires getting all authors? sign-off in order to change licensing information and such. The FreeBSD project for instance has had to hop through a lot of hoops to change code from BSD 3-clause to 2-clause because some of the authors didn?t sign over the code to the project when contributing it, since the concern with signing off on code and such predated the code contribution.

Unless there?s a real need for consolidating the LICENSE files, I?d leave it well enough alone in the source tree and just aggregate all of the licenses as an uber license and distribute it with the binary packages.

That?s just my 2 cents,
-Enji
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210604/461ce00b/attachment.sig>
