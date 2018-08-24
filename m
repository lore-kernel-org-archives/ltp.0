From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Fri, 24 Aug 2018 14:27:55 -0400
Subject: [LTP] [PATCH 1/5] acpi_hotplug: Add library file for ACPI based
 cpu and memory hotplug
In-Reply-To: <20180824161208.GB5131@rei>
References: <20180820194915.11805-1-msys.mizuma@gmail.com>
 <20180820194915.11805-2-msys.mizuma@gmail.com> <20180824161208.GB5131@rei>
Message-ID: <8ccffbf9-65ec-e365-614f-6a414f7b3878@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thank you for your comments!

On 08/24/2018 12:12 PM, Cyril Hrubis wrote:
> Hi!
>> +export HOTPLUGABLE_CONTAINER=
>> +export HOTPLUGABLE_NODES=()
> 
> Arrays are bashism, the best we can do in portable shell is to emulate
> arrays by appending the nodes into a variable and separate them by
> spaces.

Got it.

> 
>> +RETRY=5
>> +RETRY_TIME=60
>> +
>> +# $1: node number
>> +is_memoryless_node()
>> +{
>> +	local node=$1
>> +
>> +	numactl -H | awk '
>> +		/node '$node' size:/ {
>> +			if ($4 == 0)
>> +				prine 1
>                                   ^
> 				  Typo?
>> +			else
>> +				print 0
>> +		}'
>> +}
>> +
>> +# $1: node number
>> +is_movable_node()
>> +{
>> +	local node=$1
>> +
>> +	awk '
>> +	BEGIN {
>> +		zone = ""
>> +		NotMovableFound = 0
>> +		nextnode = '$node' + 1
>> +	}
>> +	/^Node '$node'/{
>> +		zone = $4
>> +	}
>> +	/present/ {
>> +		if (zone != "") {
>> +			if ((zone != "Movable") && ($2 != 0)) {
>> +				NotMovableFound = 1
>> +				exit
>> +			}
>> +		}
>> +	}
>> +	match($0, "^Node " nextnode) {
>> +		exit
>> +	}
>> +
>> +	END {
>> +		if (NotMovableFound == 0)
>> +			print 1
>> +		else
>> +			print 0
>> +	}
>> +	' /proc/zoneinfo
> 
> 
> This looks far to complex, what exactly are we trying to figure out here?

This code checks the node is movable node or not.
I will try to simplify this...

> 
>> +}
>> +
>> +stop_udev()
>> +{
>> +	systemctl stop systemd-udevd-kernel.socket
>> +	systemctl stop systemd-udevd-control.socket
>> +	systemctl stop systemd-udevd.service
>> +}
>> +
>> +resume_udev()
>> +{
>> +	systemctl start systemd-udevd.service
>> +	systemctl start systemd-udevd-kernel.socket
>> +	systemctl start systemd-udevd-control.socket
>> +}
> 
> You should at least check if we are running on systemd based
> distribution before you attempt to blindly stop udev with systemctl.

Got it.

> 
>> +_setup()
> 
> Why can't we call this lib_setup() or something like that?

Thanks. I will use lib_setup.

> 
>> +{
>> +	local ACPI_CONTAINERS=()
>> +	local ONLINE_CONTAINERS=()
>> +	local CPUS=()
>> +	local tmp_NODES=()
>> +	local NODES=()
>> +	local movable_node=
>> +	local NOHP_NODES=0
> 
> Again heavy use of arrays.
> 
>> +	ACPI_CONTAINERS=( $(find /sys/devices/LNXSYSTM\:00/ -name 'ACPI0004:*') )
> 
> I'm a bit confuse here about the ACPI0004:*, what exactly is that? Is
> that a numa node or collection of numa nodes or something complete else?
> 
> I've tried to boot qemu x86_64 machine with numa emulation turned on but
> these files are not present there so I suppose that I cannot really run
> this test without specific hardware or ACPI emulation being added to
> qemu.

Actually, this test depends on the ACPI environment.
This test is useful for the specific system whose ACPI is implemented
such as the example of '9.12 Module Device; Advanced Configuration
and Power Interface (ACPI) Specification; Version 6.2 Errata A'.
I think the ACPI which qemu emulates isn't implemented such as
the example.

It is better if this test is useful in qemu, too. 
So I will try to do so.

> 
>> +	ONLINE_CONTAINERS=()
>> +	for c in ${ACPI_CONTAINERS[@]}; do
>> +		status=$(cat $c/status)
>> +		if [[ $status -ne 0 ]]; then
> 
> The [[ ]] is bashism, you should really use [ ] instead in the whole
> script.

I see.

> 
>> +			ONLINE_CONTAINERS=( ${ONLINE_CONTAINERS[@]} $c )
>> +		fi
>> +	done
>> +
>> +	if [[ ${#ONLINE_CONTAINERS[@]} -lt 2 ]]; then
>> +		tst_brk TCONF "The number of online ACPI containers is not enough. 2 or more online ACPI containers are needed, but this system has ${#ONLINE_CONTAINERS[@]} contianers."
> 
> This line is far too long. The result message has to be short and to the
> point.

Got it.

> 
>> +	fi
>> +
>> +	for c in ${ONLINE_CONTAINERS[@]}; do
>> +		CPUS=( $(find $c -name 'ACPI0007:*' ) )
>> +		tmp_NODES=()
>> +		NODES=()
>> +		NOHP_NODES=0
>> +		for cpu in ${CPUS[@]}; do
>> +			tmp_NODES=( ${tmp_NODES[@]} $(ls $cpu/physical_node/ 2> /dev/null | grep ^node | sed -e 's/node//') )
>> +		done
>> +		NODES=( $(echo ${tmp_NODES[@]} | tr ' ' '\n' | sort | uniq ) )
>> +
>> +		# Memory device ID is PNP0C80, however, the memory ID is not used here
>> +		# but the node ID is used.
>> +		# The hotplugable memory section has ACPI_SRAT_MEM_HOT_PLUGGABLE flag
>> +		# and the zone is handled as Movable zone. Following assumes that
>> +		# the node has only Movable zone or it is memory less node.
>> +		# So using the node ID gets this test cleared rather than using memory ID.
>> +		for n in ${NODES[@]}; do
>> +			if [[ $(is_movable_node $n) -eq 0 ]] && [[ $(is_memoryless_node $n) -eq 0 ]]; then
>> +				NOHP_NODES=1
>> +				break
>> +			fi
>> +		done
>> +		if [[ $NOHP_NODES -eq 0 ]]; then
>> +			HOTPLUGABLE_CONTAINER=$(basename $c)
>> +			HOTPLUGABLE_NODES=( ${NODES[@]} )
>> +			break
>> +		fi
>> +	done
>> +
>> +	# Some hotplug udev rules may disturb for this test.
>> +	# Let's stop them.
>> +	stop_udev
>> +
>> +	tst_res TINFO "TARGET ACPI CONTANIER: $HOTPLUGABLE_CONTAINER"
>> +	tst_res TINFO "TARGET NODES: ${HOTPLUGABLE_NODES[@]}"
>> +}
>> +
>> +_cleanup()
>> +{
>> +	resume_udev
>> +}
>> +
>> +cpu_hp()
>> +{
>> +	local hpop=
>> +	local CPUS=( $(echo /sys/bus/acpi/devices/$HOTPLUGABLE_CONTAINER/ACPI0007:*/physical_node/online) )
>> +
>> +	local hp_cpus=${#CPUS[@]}
>> +	local current_cpus=$(nproc)
>> +	local expected_cpus=
>> +	local ACPI_CPU=
>> +	local force=0
>> +	local hotplugedcpus=0
>> +
>> +	if [[ $1 == "hotremove" ]]; then
>> +		hpop=0
>> +	else
>> +		hpop=1
>> +	fi
>> +	if [[ $2 == "force" ]]; then
>> +		force=1
>> +	fi
> 
> It does not seem to make any sense to conver the parametes to numbers
> just to save a few characters in the ifs below.
> 
>> +	if [[ $hpop -eq 0 ]]; then
>> +		expected_cpus=$(( current_cpus - hp_cpus ))
>> +	else
>> +		expected_cpus=$(( current_cpus + hp_cpus ))
>> +	fi
>> +
>> +	for cpu in ${CPUS[@]}; do
>> +		echo -n $hpop > $cpu 2> /dev/null
>> +		ACPI_CPU=$( echo $cpu | sed -e 's#/sys/bus/acpi/devices/ACPI0004:[0-9a-f]\+/\(ACPI0007:.*\)/physical_node/online#\1#')
>> +		if [[ $? -ne 0 ]]; then
>> +			tst_res TINFO "CPU: $ACPI_CPU $1 failed."
>> +			if [[ $force -eq 0 ]]; then
>> +				return 1
>> +			fi
>> +		else
>> +			if [[ $force -ne 0 ]]; then
>> +				tst_res TINFO "CPU: $ACPI_CPU $1 successed."
>> +			fi
>> +			hotplugedcpus=$(( hotplugedcpus  + 1 ))
>> +		fi
>> +	done
> 
> And actually the force parameter should have rather been
> "ignore_failure" or something similar.
> 
>> +	tst_res TINFO "CPU: current: $(nproc) hotpluged: $hotplugedcpus"
>> +	if [[ $(nproc) -eq $expected_cpus ]]; then
>> +		return 0
>> +	else
>> +		return 1
>> +	fi
> 
> Also why do we return result here instead of doing tst_res TPASS and
> tst_res TFAIL directly?

Thanks. I will use tst_res.

> 
>> +}
>> +
>> +# $1: node number
>> +# $2: expected memory size (MB)
>> +memhp_result()
>> +{
>> +	local node=$1
>> +	local expected=$2
>> +	local current=
>> +
>> +	current=$(numactl -H | awk '
>> +	/^node '$node' size/ {
>> +		print $4
>> +	}
>> +	')
>> +
>> +	if [[ $current -eq $expected ]]; then
>> +		echo 1
>> +	else
>> +		echo 0
>> +	fi
>> +}
>> +
>> +memory_hp()
>> +{
>> +	local hpop=
>> +	local memory=()
>> +	local memhpdone=
>> +	local expected=
>> +	local block_size_bytes=$(cat /sys/devices/system/memory/block_size_bytes )
>> +	block_size_bytes=$(echo "obase=10;ibase=16;$block_size_bytes" | bc)
>> +	local result=0
>> +	local force=0
>> +	local hotplugedsections=
>> +	local removable=
>> +
>> +	declare -A mem_hotpluged
> 
> Again heavy use of arrays, also declare is bashism as well.
> 
>> +	if [[ $1 == "hotremove" ]]; then
>> +		hpop="offline"
>> +	else
>> +		hpop="online_movable"
>> +	fi
>> +	if [[ $2 == "force" ]]; then
>> +		force=1
>> +	fi
> 
> Again why do we convert the parameters? We should have passed the
> hotremove and offlineremove in the tests instead of converting it here.
> 
>> +	for node in ${HOTPLUGABLE_NODES[@]}; do
>> +		memory=$(ls /sys/devices/system/node/node$node/ | grep memory | sort -n -r)
>> +		for mem in ${memory[@]}; do
>> +			if [[ $force -eq 1 ]]; then
>> +				echo -n $hpop > /sys/devices/system/node/node$node/$mem/state 2> /dev/null
>> +				mem_hotpluged[$node]=$(( mem_hotpluged[$node] + 1 ))
>> +				hotplugedsections=$(( hotplugedsections + 1 ))
>> +			else
>> +				memhpdone=0
>> +				for ((i = 1; i <= RETRY; i++)); do
>> +					echo -n $hpop > /sys/devices/system/node/node$node/$mem/state
>> +					if [[ $? -eq 0 ]]; then
>> +						memhpdone=1
>> +						break
>> +					else
>> +						removable=$(cat /sys/devices/system/node/node$node/$mem/removable)
>> +						if [[ $removable -ne 1 ]]; then
>> +							tst_res TINFO "memory: Node: $node section: $mem something wrong..."
>> +							return 1
>> +						fi
>> +						tst_res TINFO "memory: Node: $node section: $mem $1 failed ($i times). Retry..."
>> +					fi
>> +					sleep $RETRY_TIME
>> +				done
>> +				if [[ $memhpdone -eq 0 ]]; then
>> +					tst_res TINFO "memory: Node: $node section: $mem $1 failed."
>> +					return 1
>> +				else
>> +					tst_res TINFO "memory: Node: $node section: $mem $1 successed."
>> +					mem_hotpluged[$node]=$(( mem_hotpluged[$node] + 1 ))
>> +					hotplugedsections=$(( hotplugedsections + 1 ))
>> +				fi
>> +			fi
>> +		done
>> +	done
>> +
>> +	for node in ${HOTPLUGABLE_NODES[@]}; do
>> +		if [[ $hpop == "offline" ]]; then
>> +			expected=0
>> +		else
>> +			expected=$(echo "${mem_hotpluged[$node]} * $block_size_bytes/1024/1024" | bc)
>> +		fi
>> +		if [[ $(memhp_result $node $expected) -ne 1 ]]; then
>> +			result=$((result + 1))
>> +		fi
>> +		tst_res TINFO "Memory: Node: $node $hotplugedsections sections hotpluged."
>> +	done
>> +
>> +	return $result
>> +}
> 
> Does this function have anything to do with an ACPI? It looks to me like
> we use just generic sysfs interface for hotplugging the memory.

The ACPI device ID of memory device is PNP0C80, however the memory hotplug
is operated per memory section, and the node actually. So, above code 
uses the sysfs of memory section and node.
It may be better that the relation between PNP0C80 and memory section/node
gets cleared. I will try to modify this.

> 
>> +container_hp()
>> +{
>> +	local hpop=
>> +	local online_ret=0
>> +
>> +	if [[ $1 == "hotremove" ]]; then
>> +		hpop=0
>> +	else
>> +		hpop=1
>> +	fi
>> +
>> +	echo $hpop > /sys/bus/acpi/devices/$HOTPLUGABLE_CONTAINER/physical_node/online
>> +	online_ret=$?
>> +
>> +	if [[ $online_ret -ne 0 ]]; then
>> +		tst_res TINFO "ACPI container: $HOTPLUGABLE_CONTAINER $1 failed."
>> +		numactl -H
>> +		return 1
>> +	else
>> +		tst_res TINFO "ACPI container: $HOTPLUGABLE_CONTAINER $1 successed."
>> +	fi
>> +
>> +	return 0
>> +}
> 
> All in all this code looks quite brittle to me, as we do parse procfs
> files and output from numactl which may differ sligtly over different
> distributions/kernel versions.
> 

Thank you for your review!
I will fix them up.

Thanks,
Masa
