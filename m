From: Li Wang <liwang@redhat.com>
Date: Fri, 15 May 2020 15:04:06 +0800
Subject: [LTP] [PATCH v2 1/4] INSTALL: Update requirements
In-Reply-To: <20200515062221.GB5117@dell5510>
References: <20200514190906.27130-1-pvorel@suse.cz>
 <CAEemH2e5G53VPLp4bOe_i-2_4eRSF9dbTC378rqN-AwGanUTEw@mail.gmail.com>
 <20200515062221.GB5117@dell5510>
Message-ID: <CAEemH2fQ3yfDfNqNeUfLAAWY6hUDcEybbU+dK=hwrwg2rFj60A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 15, 2020 at 2:22 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> thanks for your review!
>
> > As we know most distributions provide the requirements packages already,
> > so I'm thinking if we can replace the download link only by installing
> > commands, that will make people easily prepare their test environment.
>
> > Which something maybe likes:
> > --------------------------------------
>
> > +       #### Debian/Ubuntu
> > +       ```
> > +       sudo apt-get install make
> > +       sudo apt-get install pkgconf
> > +       sudo apt-get install autoconf
> > +       sudo apt-get install automake
> > +       sudo apt-get install byacc
> > +       sudo apt-get install flex
> > +       sudo apt-get install m4
> > +       ```
> Maybe this:
>
> Debian / Ubuntu
> # apt install gcc make pkgconf autoconf automake bison flex m4
> linux-headers-$(uname -r) libc6-dev
>
> OpenSUSE / SLES
> # zypper install gcc make pkgconf autoconf automake bison flex m4
> linux-glibc-devel glibc-devel
>
> Fedora / CentOS / RHEL
> # yum install gcc make pkgconf autoconf automake bison flex m4
> kernel-headers glibc-headers
>
> I'd prefer it in simple form (single line) + I thought bison is more
> common than
> byacc (but maybe I'm wrong). I'm not a big fan of sudo (but can add it
> there).
>

Sure, I have no preference here :). I added the 'sudo' just because I
noticed that the INSTALL use many $ before commands which means in non-root
user.



> + Added headers and gcc. But on the other hand I wanted to have package
> reference in
> travis/*.sh (where are missing some packages which are installed by
> default with
> gcc, e.g. , but it does not harm to have it offline.
>
+1

>
> Should I remove links to the tools? And we obviously don't list a compiler.
>

Personally I think links are useless, people opened this INSTALL could also
have the ability to use google for finding the package link:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200515/8e0ad7ef/attachment.htm>
