From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Jul 2021 08:40:38 +0200
Subject: [LTP] [PATCH 1/1] tst_net.sh: Declare prefix variable as empty
In-Reply-To: <34959e10-45fc-f7ea-9e2d-ebe186a97859@jv-coder.de>
References: <20210709140143.9180-1-pvorel@suse.cz>
 <CAEemH2fB5VakafKhTgcOsvwK6Q50AJ3WcpRY2fSLfhB86b03Nw@mail.gmail.com>
 <YOvX/tczl7Duu+6L@pevik>
 <34959e10-45fc-f7ea-9e2d-ebe186a97859@jv-coder.de>
Message-ID: <YOvj5p/5KL2uRNpT@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi,

> On 7/12/2021 7:49 AM, Petr Vorel wrote:
> > Thanks for a review!
> > It's a bit strange to add '=' only single variable, maybe I should have rename
> > the variable.

> > Paranoid approach would be to add '=' to any variable which is assigned only on
> > some circumstance or even any variable which is not assigned to any value.
> > But we probably don't want to do it.
> I think good common practice would be to add it to all variables, where it
> matters.
> There are probably only very few places, where a local variable is not
> assigned before being accessed.
> Maybe there is some kind of shell code linter, that can find uninitialized
> variables?
> A good linter could also find variables, that should be local, but are not.
> But I have never looked into shell code linting.

Thanks for your input.

I'm aware only of shellcheck [1], which I'm not a big fan of (false positives,
useless hints). And yes, in this case it warns about 'local' not being POSIX
=> useless :(.

In testcases/lib/tst_net.sh line 411:
	local counter host_id host_range is_counter max_host_id min_host_id net_id prefix tmp type
        ^-- SC3043: In POSIX sh, 'local' is undefined.


> In fs_bind_lib.sh, OPTIND in fs_bind_check probably also requires setting to
> empty, or better 0.
We use tst_test.sh in OPTIND=1 ("The index of the next argument to be processed
by the getopts builtin command")

> But maybe dash's implementation of getopts does not require it. I only had
> to add local OPTIND for busybox sh iirc...
I used to set local OPTIND (in tst_net.sh), which is obviously not working on
dash.

> Yet another case of: Shellcode is unpredictable :)
Yep, I love shell (understand why everything is slowly rewritten into C).

Kind regards,
Petr

> Joerg

[1] https://github.com/koalaman/shellcheck
