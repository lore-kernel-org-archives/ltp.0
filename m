From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 08:22:21 +0200
Subject: [LTP] [PATCH v2 1/4] INSTALL: Update requirements
In-Reply-To: <CAEemH2e5G53VPLp4bOe_i-2_4eRSF9dbTC378rqN-AwGanUTEw@mail.gmail.com>
References: <20200514190906.27130-1-pvorel@suse.cz>
 <CAEemH2e5G53VPLp4bOe_i-2_4eRSF9dbTC378rqN-AwGanUTEw@mail.gmail.com>
Message-ID: <20200515062221.GB5117@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

thanks for your review!

> As we know most distributions provide the requirements packages already,
> so I'm thinking if we can replace the download link only by installing
> commands, that will make people easily prepare their test environment.

> Which something maybe likes:
> --------------------------------------

> +       #### Debian/Ubuntu
> +       ```
> +       sudo apt-get install make
> +       sudo apt-get install pkgconf
> +       sudo apt-get install autoconf
> +       sudo apt-get install automake
> +       sudo apt-get install byacc
> +       sudo apt-get install flex
> +       sudo apt-get install m4
> +       ```
Maybe this:

Debian / Ubuntu
# apt install gcc make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev

OpenSUSE / SLES
# zypper install gcc make pkgconf autoconf automake bison flex m4 linux-glibc-devel glibc-devel

Fedora / CentOS / RHEL
# yum install gcc make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers

I'd prefer it in simple form (single line) + I thought bison is more common than
byacc (but maybe I'm wrong). I'm not a big fan of sudo (but can add it there).
+ Added headers and gcc. But on the other hand I wanted to have package reference in
travis/*.sh (where are missing some packages which are installed by default with
gcc, e.g. , but it does not harm to have it offline.

Should I remove links to the tools? And we obviously don't list a compiler.

> +
> +       #### OpenSUSE
> +       ```
> +       sudo zypper install make
> +       sudo zypper install pkgconf
> +       sudo zypper install autoconf
> +       sudo zypper install automake
> +       sudo zypper install byacc
> +       sudo zypper install flex
> +       sudo zypper install m4
> +       ```
> +       #### Fedora/CentOS/RHEL
> +       ```
> +       sudo yum install make
> +       sudo yum install pkgconf
> +       sudo yum install autoconf
> +       sudo yum install automake
> +       sudo yum install byacc
> +       sudo yum install flex
> +       sudo yum install m4
> +       ```

> Anyway, this is a good update for documents, I hope these could be involved
> in the newly released.
> [CC Cyril to notice this]
Yep, that was the intention of this late evening patches :).

Kind regards,
Petr
