From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 8 Nov 2017 14:42:22 +0100
Subject: [LTP] [RFC PATCH] scripts: Dump /proc and /sys
In-Reply-To: <20171107140219.5606-1-rpalethorpe@suse.com>
References: <20171107140219.5606-1-rpalethorpe@suse.com>
Message-ID: <20171108134221.5ogyueuisylmmmci@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

the script does quite a big load:

I'd set it executable bit (0755 instead of 0644).
IMHO this script should be run as root, or lots of sensitive info will be lost.
It's not also installed to SUT (but it's meant to be used on SUT).

> +usage: ${0##*/}	[ [ -d dump_dir ]
> + 			[ -w white_list ] [ -u use_white_list ]
> + 			[ -t timeout ]
> + 			[ -b batch_size ]
> + 			|  -h ]
How about this?
USAGE:
${0##*/} [ -d dump_dir ] [ -w white_list ] [ -u use_white_list ] [ -t timeout ]
		 [ -b batch_size ]
${0##*/} -h

...
> +if [ ! $use_white_list ]
> +then echo Finding files in /proc and /sys
IMHO this syntax is more common, but it's a matter of taste:
if [ ! $use_white_list ]; then
	echo Finding files in /proc and /sys
...

> +     proc_files=$(find -L /proc -maxdepth 4 -readable -not -regex '/proc/[0-9]+/.*' -not -type d 2> /dev/null)
This gets files in /proc/self and /proc/thread-self. I don't think we want it.
Also it gets symlinks (maybe not a problem),

and files not readable:
dd: error reading '/proc/sys/fs/binfmt_misc/register': Invalid argument
dd: error reading '/proc/sysrq-trigger': Input/output error
ls -l /proc/sys/fs/binfmt_misc/register /proc/sysrq-trigger
--w------- 1 root root 0 lis  8 07:45 /proc/sys/fs/binfmt_misc/register
--w------- 1 root root 0 lis  8 07:45 /proc/sysrq-trigger
Maybe using -perm instead of -readable (find(1) says that 

> +     sys_files=$(find -L /sys -maxdepth 4 -readable -not -type d 2> /dev/null)
> +     files="$proc_files $sys_files"
> +else echo Using file list $use_white_list
> +     files=$(cat $use_white_list)
> +fi
> +
> +dump_dir=${dump_dir%/}
> +echo Dumping to $dump_dir
IMHO it's better to quote string for echo, even not required.
echo "Dumping to $dump_dir"
> +rm -rf $dump_dir
> +mkdir $dump_dir
> +
> +count=$batch_size
> +for f in $files
> +do
Again here:
for f in $files; do

> +    mkdir -p $dump_dir$(dirname $f)
> +    ({
Wouldn't be using '(' enough? (I suppose using subshell is safer than '{') and you don't
need to use '&'.
But I don't like the whole block being run in background.

Kind regards,
Petr
