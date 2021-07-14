From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jul 2021 10:40:01 +0200
Subject: [LTP] [PATCH v2] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <dc6520e5-5bc3-b277-c33a-a553632e27a5@jv-coder.de>
References: <20210714055253.1668374-1-lkml@jv-coder.de>
 <871r81pes4.fsf@suse.de>
 <dc6520e5-5bc3-b277-c33a-a553632e27a5@jv-coder.de>
Message-ID: <YO6i4QqnULLpsoZv@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> + * [DESCRIPTION]
> > I think it is [Description] now.
> Both seem to work and there is no documentation for this.
> But looks the lower case variant is used more often. Will update this 
> for v3.

I started with uppercase but then everybody else decided that only first
letter in uppercase is the right thing. Ideally there should be only
[Description] in the tree at this point.

> >> + *
> >> +
> >> +	/* Create squashfs without any comporession.
> >> +	 * This allows reasoning about block sizes
> >> +	 */
> >> +	TST_EXP_PASS(tst_system(
> >> +		"mksquashfs data image.raw -noI -noD -noX -noF >/dev/null 2>&1"
> > I guess the existing API functions to create an image will not work with
> > squashfs?
> Honestly I don't know what they are... If it is .format_device stuff, 
> then no, this cannot be used
> for squashfs, because the data has to be prepared, before the filesystem 
> can be created.

Indeed, there is not much to be done here.

>  ???????? SAFE_MKDIR("mnt", 0777);
> -?????? TST_EXP_PASS(tst_system("mount -tsquashfs -oloop image.raw mnt"));
> +?????? TST_EXP_PASS(mount(tst_device->dev, "mnt", "squashfs", 0, NULL));

I do not think that it matters that much who allocates the device, if
it's the test library or the kernel code. I guess that in both cases it
just picks up the first free device anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
